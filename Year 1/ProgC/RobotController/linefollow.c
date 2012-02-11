/******************************************************************************
* Project name            : Robot buggy line following                        *
* Created by              : Silvestrs Timofejevs, 11000746                    *
* Date created            : 31.01.2012.                                       *
******************************************************************************/                                   
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <getopt.h>
#include <ctype.h>
#include <comedi.h>
#include <comedilib.h>

unsigned int read_settings (unsigned int subdevice, comedi_t *device);
void initialization (unsigned int in_subdevice, char *filename, comedi_t **device);
int line_following (comedi_t *device, char *filename);

 /*****************************************************************************
 * Function name         : initialization                                     *
 *   Returns             : no return value                                    *
 *   in_subdevice        : passes id of a subdevice                           *
 *   *filename           : pointer to file location variable                  *
 *   **device            : passes adress of a comedi_t type device handle     *
 * into function.                                                             *
 * Created by            : Silvestrs Timofejevs                               *
 * Date created          : 17.11.2011.                                        *
 * Description           : Opens the comedi device, checks if there is a      *
 * valid bidirectional DIO port subdevice, configures ports for output.       *
 * Modifies device handle variable in main()                                  *
 *****************************************************************************/
void initialization (unsigned int in_subdevice, char *filename, comedi_t **device)
{ 
  int stype;
  int i, retval;

  /* open the comedi device, exit with error message if something goes wrong. */
  *device=comedi_open(filename);
  if(!(*device))
  {
    comedi_perror(filename);
    exit(0);
  }

  /* check we have a valid bidirection DIO port subdevice*/
  stype = comedi_get_subdevice_type(*device, in_subdevice);
  if(stype!=COMEDI_SUBD_DIO)
  {
    printf("%d is not a digital I/O subdevice\n", in_subdevice);
    exit(0);
  }

	/* configure ports for output */
    for(i=0;i<8;i++)
      retval=comedi_dio_config(*device, in_subdevice,i,COMEDI_OUTPUT);
 
}
 /*****************************************************************************
 * Function name         : read_settings                                      *
 *   returns             : returns current rack switch pattern                *
 *   subdevice           : passes id of subdevice into function               *
 *   *device              : passes comedi device file handle into function    *
 * Created by            : Silvestrs Timofejevs                               *
 * Date created          : 14.11.2011.										  *
 * Date modified		 : 31.01.2012.										  *
 * Description           : Read current switch pattern from a rack. Modifies  *
 * value it read, so that it holds only 8bit value that represents current    *
 * rack switch pattern.                                                       *
 * Moves it to first 8 least significant bits.                                *
 * Inverts current value (rack switches active state is 0).                   *
 * Fills the rest of variable it doesn`t use with zeros.                      *
 *****************************************************************************/
unsigned int read_settings (unsigned int subdevice, comedi_t *device)
{
  unsigned int sensors;
  
  comedi_dio_bitfield(device, subdevice, 0x00, &sensors); /* reads current switch pattern */
  sensors = sensors & 0x0000ff00;                  	      /* obtains switch pattern */
  sensors >>= 8;						                  /* moves switch pattern to first byte */
  sensors = ~sensors;				         		      /* changes active state to 1 */
  sensors = sensors & 0x000000ff;	                      /* clears unused bits of variable */
  return sensors;
}


/*****************************************************************************
* Function name			:  line_following									 *
*	returns				:  0 on line loose time-out, 1 on obstruction		 *
*   subdevice           :  passes id of subdevice into function              *
*   *device             :  passes comedi device file handle into function    *
*	*filename			:  passes the pointer to comedi API file location	 *
* Created by            :  Silvestrs Timofejevs                              *
* Date created          :  31.01.2012.										 *
* Description           :  Follows the white line, untill time-out on line	 *
* loose occurs, or physical obstruction has been encountered.				 *
*****************************************************************************/
int line_following (comedi_t *device, char* filename)
{
  const int subdevice = 1;					/* Subdevice for analogue output */
  const int rmotor = 1, lmotor = 0;			/* Right and left motor values for comedi device */
  const int range = 1;						/* Voltage range value ( -10v to 10v) */
  const int timeOff_period = 25;			/* Time ratio pereod untill curve intensity increase */
  const int maxCurve_ratio = 7;				/* Maximal curve ratio */
  const int TTL = 500;						/* Time ratio off the line limit */
  
  int lmotor_val, rmotor_val				/* Right and left motor value */
  int timeOff_ratio = 0, curve_ratio = 1;	/* Count till curve intensity increase */
  int right_curve							/* Right motor value in curve */
  int curve_step = 100;						/* Curve intensity step */
  
  while (1)
  {
  
  curve_ratio = 1;
  timeOff_ratio  = 0;
  
  switch (read_settings (2, device))
  {
	
	/* both sensors off the line */
    case 0:
	lmotor_val = 3500;
	rmotor_val = 2800;
	  
	  while (read_settings (2, device) == 0)		/* while off the line */
	  {
	    if ((timeOff_ratio > timeOff_period) && (curve_ratio < maxCurve_ratio))	
	    {											/* if 1/4 second of the line, increase curve  */
	    timeOff_ratio = 0;
	    curve_ratio++;
	    }
		
	  timeOff_ratio++;							    /* + 1/100 of a second off the line */

	  comedi_data_write (device, subdevice, lmotor, range, AREF_GROUND, lmotor_val);	/* Set left motor value */
	  right_curve = rmotor_val - (curve_step * curve_ratio);							/* Curve intensity */
	  comedi_data_write (device, subdevice, rmotor, range, AREF_GROUND, right_curve);	/* Set right motor value */
	  usleep (10000); 																	/* Delay 1/100 of a second */
	  
	  totalTimeoff_ratio++;
	  if (totalTimeOff_ratio > TTL )				/* return from function, off the line for more than 5 secs */
	    return 0; 
		
	  if (read_settings (2, device) > 3)			/* return from function on obstruction encounter */
	    return 1;
	  }
	break;
	
	/* left sensor on the line, right sensor off the line */
	case 1:
	lmotor_val = 0;
	rmotor_val = 3500;

	/* right sensor on the line, left sensor off the line */
	case 2:
	lmotor_val = 3500;
	rmotor_val = 3000;
	
	/* both sensors on the line */
	case 3:	 
	lmotor_val = 0;
	rmotor_val = 3500;
	break;
	
	default:
	return 1;
	break
  break;	
  }
		
  comedi_data_write (device, subdevice, lmotor, range, AREF_GROUND, lmotor_val);	    /* Set left motor value */
  comedi_data_write (device, subdevice, rmotor, range, AREF_GROUND, rmotor_val);		/* Set right motor value */
 }
}

int main (void)
{
  comedi_t *device;
  unsigned int subdevice = 2;
  char *filename = "/dev/comedi0";
  int i;
 
  initialization (subdevice, filename, &device);
  line_following (device, filename);
   comedi_data_write (device,1, 0, 1, AREF_GROUND, 2047);
   comedi_data_write (device, 1, 1, 1, AREF_GROUND, 2047);
  return 0;
}
