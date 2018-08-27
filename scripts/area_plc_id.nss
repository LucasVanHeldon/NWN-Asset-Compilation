// Identify all objects in all containers in the specified area. If no
// valid area is provided, the caller's current area will be searched.
//
// area         The area in which to search for object containers.
void cs_util_IdentifyObjects(object area = OBJECT_INVALID);
//----------------------------------------------------------------------------
int cs_util_ObjectsPerPass = 20;   // Number of containers to check in a pass.
// Call this with a parameter of 0. passCount is used to track recursive calls.
void cs_util_IdentifyObjectsInternal(object area, int passCount) {
    // Find where we were last up to in the object list. We seem to need
    // to do this as the object iterator gets reset between script calls.
    object obj = GetFirstObjectInArea(area);
    int i;
    for (i = 0; i < passCount; i++) {
        obj = GetNextObjectInArea(area);
    }
    // Cycle through objectsPerPass objects in the area looking for items.
    int count = 0;
    while (GetIsObjectValid(obj) && (count < cs_util_ObjectsPerPass)) {
        // Is this item a container? If so, cycle through its items and
        // force everything to be identified.
        if (GetHasInventory(obj) && !(GetIsPC(obj))) {
            object item = GetFirstItemInInventory(obj);
            while (GetIsObjectValid(item)) {
                SetIdentified(item, TRUE);
                item = GetNextItemInInventory(obj);
            }
        }
        obj = GetNextObjectInArea(area);
        count++;
    }
    // Identify the next block of objects if we haven't finished.
    if (GetIsObjectValid(obj)) {
        DelayCommand(0.0, cs_util_IdentifyObjectsInternal(area, passCount + 1));
    }
}
//----------------------------------------------------------------------------
// This function breaks down the process of identifying all objects in an area
// into multiple passes and re-schedules function calls with DelayCommand to
// avoid hitting the engine's maximum instructions limit. Ultimately this
// approach too will hit the maximum instruction limit, but that would need
// a *lot* of items...
void cs_util_IdentifyObjects(object area = OBJECT_INVALID)
{
   cs_util_IdentifyObjectsInternal(area, 0);
}

void main()
{
cs_util_IdentifyObjects(OBJECT_SELF);
}

