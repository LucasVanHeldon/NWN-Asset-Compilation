#include "x0_i0_secret"
#include "inc_detectsecret"
string BagTag()
{

    return "lootbag";
}

void main()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,5.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsPC(oC))
        {
            SendMessageToPC(oC,"PC Detected");
            if(DetectSecretItem(oC))
            {
                SendMessageToPC(oC,"You have found something.");

                CreateObject(OBJECT_TYPE_PLACEABLE,
                            BagTag(),
                            GetLocation(OBJECT_SELF));
                DelayCommand(6.0,DestroyObject(OBJECT_SELF));
                break;
             }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,5.0,GetLocation(OBJECT_SELF));
    }
}

