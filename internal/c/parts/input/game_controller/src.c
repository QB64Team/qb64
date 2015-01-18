#include "src/gamepad/Gamepad.h"

/*
struct Gamepad_device {
	// Unique device identifier for application session, starting at 0 for the first device attached and
	// incrementing by 1 for each additional device. If a device is removed and subsequently reattached
	// during the same application session, it will have a new deviceID.
	unsigned int deviceID;
	
	// Human-readable device name
	const char * description;
	
	// USB vendor/product IDs as returned by the driver. Can be used to determine the particular model of device represented.
	int vendorID;
	int productID;
	
	// Number of axis elements belonging to the device
	unsigned int numAxes;
	
	// Number of button elements belonging to the device
	unsigned int numButtons;
	
	// Array[numAxes] of values representing the current state of each axis, in the range [-1..1]
	float * axisStates;
	
	// Array[numButtons] of values representing the current state of each button
	bool * buttonStates;
	
	// Platform-specific device data storage. Don't touch unless you know what you're doing and don't
	// mind your code breaking in future versions of this library.
	void * privateData;
};
*/


bool verbose = false;

char *verboseMessage=(char*)malloc(1000);

void onButtonDown(struct Gamepad_device * device, unsigned int buttonID, double timestamp, void * context) {
	//buttonId is base 0

	if (verbose) {		
		sprintf(verboseMessage,"Button %u down on device %u at %f with context %p\n", buttonID, device->deviceID, timestamp, context);
		cout<<verboseMessage;
	}

	int button = buttonID;

	int32 di,controller;
        controller=0;
        for(di=1;di<=device_last;di++){
          static device_struct *d;
          d=&devices[di];
          if (d->used==1){
          if (d->type==1){
          controller++;
	  if (d->handle_int==device->deviceID){

            //ON STRIG event
            static int32 i;
            if (controller<=256&&button<=255){//within supported range
              i=(controller-1)*256+button;
              if (onstrig[i].active){
            if (onstrig[i].id){
              if (onstrig[i].active==1){//(1)ON
                onstrig[i].state++;
              }else{//(2)STOP
                onstrig[i].state=1;
              }
              qbevent=1;
            }
              }
            }//within supported range

            uint8 *cp,*cp2;
            if (d->queued_events==d->max_events){//expand/shift event buffer
              if (d->max_events>=QUEUED_EVENTS_LIMIT){
            //discard base message
            memmove(d->events,d->events+d->event_size,(d->queued_events-1)*d->event_size);
            d->queued_events--;
              }else{
            cp=(uint8*)calloc(d->max_events*2,d->event_size);
            memcpy(cp,d->events,d->queued_events*d->event_size);//copy existing events
            cp2=d->events;
            d->events=cp;
            free(cp2);
            d->max_events*=2;
              }
            }
            memmove(d->events+d->queued_events*d->event_size,d->events+(d->queued_events-1)*d->event_size,d->event_size);//duplicate last event
            *(int64*)(d->events+(d->queued_events*d->event_size)+(d->event_size-8))=device_event_index++;//store global event index
            //make required changes
            *(d->events+(d->queued_events*d->event_size)+button)=1;
            d->queued_events++;
            //set STRIG_button_pressed for button
            if (button>=0&&button<=255){
              d->STRIG_button_pressed[button]=1;
            }
          }//js index
        }//type==1
          }//used
        }//di

}

void onButtonUp(struct Gamepad_device * device, unsigned int buttonID, double timestamp, void * context) {
	if (verbose) {
		sprintf(verboseMessage,"Button %u up on device %u at %f with context %p\n", buttonID, device->deviceID, timestamp, context);
		cout<<verboseMessage;
	}


	int button = buttonID;

	int32 di;
        for(di=1;di<=device_last;di++){
          static device_struct *d;
          d=&devices[di];
          if (d->used==1){
        if (d->type==1){
	  if (d->handle_int==device->deviceID){
            uint8 *cp,*cp2;
            if (d->queued_events==d->max_events){//expand/shift event buffer
              if (d->max_events>=QUEUED_EVENTS_LIMIT){
            //discard base message
            memmove(d->events,d->events+d->event_size,(d->queued_events-1)*d->event_size);
            d->queued_events--;
              }else{
            cp=(uint8*)calloc(d->max_events*2,d->event_size);
            memcpy(cp,d->events,d->queued_events*d->event_size);//copy existing events
            cp2=d->events;
            d->events=cp;
            free(cp2);
            d->max_events*=2;
              }
            }
            memmove(d->events+d->queued_events*d->event_size,d->events+(d->queued_events-1)*d->event_size,d->event_size);//duplicate last event
            *(int64*)(d->events+(d->queued_events*d->event_size)+(d->event_size-8))=device_event_index++;//store global event index
            //make required changes
            *(d->events+(d->queued_events*d->event_size)+button)=0;
            d->queued_events++;
          }//js index
        }//type==1
          }//used
        }//di

}

void onAxisMoved(struct Gamepad_device * device, unsigned int axisID, float value, float lastValue, double timestamp, void * context) {
	if (verbose) {
		sprintf(verboseMessage,"Axis %u moved from %f to %f on device %u at %f with context %p\n", axisID, lastValue, value, device->deviceID, timestamp, context);
		cout<<verboseMessage;
	}

	int axis=axisID;

	int32 di;

        for(di=1;di<=device_last;di++){
          static device_struct *d;
          d=&devices[di];
          if (d->used==1){
        if (d->type==1){
	  if (d->handle_int==device->deviceID){
            uint8 *cp,*cp2;
            if (d->queued_events==d->max_events){//expand/shift event buffer
              if (d->max_events>=QUEUED_EVENTS_LIMIT){
            //discard base message
            memmove(d->events,d->events+d->event_size,(d->queued_events-1)*d->event_size);
            d->queued_events--;
              }else{
            cp=(uint8*)calloc(d->max_events*2,d->event_size);
            memcpy(cp,d->events,d->queued_events*d->event_size);//copy existing events
            cp2=d->events;
            d->events=cp;
            free(cp2);
            d->max_events*=2;
              }
            }
            memmove(d->events+d->queued_events*d->event_size,d->events+(d->queued_events-1)*d->event_size,d->event_size);//duplicate last event
            *(int64*)(d->events+(d->queued_events*d->event_size)+(d->event_size-8))=device_event_index++;//store global event index
            //make required changes	    
            float f;
            f=value;
	    /*
            if (f==-32768) f=-32767;
            f/=32767.0;
	    */
            if (f>1.0) f=1.0;
            if (f<-1.0) f=-1.0;
            int32 o;
            o=d->lastbutton+axis*4;
            *(float*)(d->events+(d->queued_events*d->event_size)+o)=f;
            d->queued_events++;
          }//js index
        }//type==1
          }//used
        }//di

}

void onDeviceAttached(struct Gamepad_device * device, void * context) {
	if (verbose) {
		sprintf(verboseMessage,"Device ID %u attached (vendor = 0x%X; product = 0x%X) with context %p\n", device->deviceID, device->vendorID, device->productID, context);
		cout<<verboseMessage;
	}

int i,x,x2;

//re-aquire a potentially dropped device in its original index
for (i=1;i<=device_last;i++){
if (devices[i].used){
if (devices[i].type==1){//it's a joystick/gamepad
if (!devices[i].connected){

if (device->productID==devices[i].product_id){
if (device->vendorID==devices[i].vendor_id){
if (device->numAxes==devices[i].axes){
if (device->numButtons==devices[i].buttons){
//(sometimes when gamepads are re-plugged they receieve a generic name)
//if (strlen(device->description)==strlen(devices[i].description)){//same name length
//if (strcmp(device->description,devices[i].description)==0){//same name content
	//re-acquire device
	devices[i].handle_int=device->deviceID;
	if (!devices[i].connected){
		devices[i].connected=1;
		devices[i].name[strlen(devices[i].name)-14]=0;//Remove "[DISCONNECTED]"
	}
	devices[i].used=1;
	return;
//}
//}
}
}
}
}
}

}
}
}//i

//add new device
i=device_last+1;
if (i>device_max){
	device_struct *devices=(device_struct*)realloc(devices,(device_max*2+1)*sizeof(device_struct));
	device_max*=2;
}
memset(&devices[i],0,sizeof(device_struct));
devices[i].type=1;
devices[i].description=strdup(device->description);
devices[i].handle_int=device->deviceID;
devices[i].buttons=device->numButtons;
devices[i].lastbutton=devices[i].buttons;
devices[i].axes=device->numAxes;
devices[i].lastaxis=devices[i].axes;
devices[i].product_id=device->productID;
devices[i].vendor_id=device->vendorID;
char name[1000];
strcpy (name,"[CONTROLLER][[NAME][");
strcat (name,devices[i].description);
strcat (name,"]]");
if (devices[i].lastbutton) strcat (name,"[BUTTON]");
if (devices[i].lastaxis) strcat (name,"[AXIS]");
if (devices[i].lastwheel) strcat (name,"[WHEEL]");
devices[i].name=strdup(name);
//calculate queue message size
x=devices[i].lastbutton+(devices[i].lastaxis+devices[i].lastwheel)*4+8;
devices[i].event_size=x;
//create initial 'current' and 'previous' events
devices[i].events=(uint8*)calloc(2,x);
devices[i].max_events=2;
devices[i].queued_events=2;
devices[i].connected=1;
devices[i].used=1;
device_last=i;

}

void onDeviceRemoved(struct Gamepad_device * device, void * context) {
	if (verbose) {
		sprintf(verboseMessage,"Device ID %u removed with context %p\n", device->deviceID, context);
		cout<<verboseMessage;
	}

int i;
for (i=1;i<=device_last;i++){
if (devices[i].used){
if (devices[i].type==1){//it's a joystick/gamepad
if (devices[i].handle_int==device->deviceID){

  char name[1000];
  strcpy(name,devices[i].name);
  strcat(name,"[DISCONNECTED]");
  char *oldname=devices[i].name;
  devices[i].name=strdup(name);
  free(oldname);
  devices[i].connected=0;
}
}
}
}//i


}

static void initGamepad() {
	Gamepad_deviceAttachFunc(onDeviceAttached, (void *) 0x1);
	Gamepad_deviceRemoveFunc(onDeviceRemoved, (void *) 0x2);
	Gamepad_buttonDownFunc(onButtonDown, (void *) 0x3);
	Gamepad_buttonUpFunc(onButtonUp, (void *) 0x4);
	Gamepad_axisMoveFunc(onAxisMoved, (void *) 0x5);
	Gamepad_init();
}

void QB64_GAMEPAD_INIT(){
	initGamepad();
}

void QB64_GAMEPAD_POLL(){
	Gamepad_detectDevices();
	Gamepad_processEvents();
}

void QB64_GAMEPAD_SHUTDOWN(){
	Gamepad_deviceAttachFunc(NULL, (void *) 0x1);
	Gamepad_deviceRemoveFunc(NULL, (void *) 0x2);
	Gamepad_buttonDownFunc(NULL, (void *) 0x3);
	Gamepad_buttonUpFunc(NULL, (void *) 0x4);
	Gamepad_axisMoveFunc(NULL, (void *) 0x5);
	Gamepad_shutdown();
}
