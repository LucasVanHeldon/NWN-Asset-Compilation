// Morbid Template (Sorcery+Undead)
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"
#include "inc_mmp"

void MMPMRBD_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    if(GetLocalInt(OBJECT_SELF,"bPDCHA"))
        if(d6() < 3)
        {
            MMP_PulseDrainCHA(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDINT"))
        if(d6() < 3)
        {
            MMP_PulseDrainINT(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDWIS"))
        if(d6() < 3)
        {
            MMP_PulseDrainWIS(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDDEX"))
        if(d6() < 3)
        {
            MMP_PulseDrainDEX(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDCON"))
        if(d6() < 3)
        {
            MMP_PulseDrainCON(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDSTR"))
        if(d6() < 3)
        {
            MMP_PulseDrainSTR(oTarget);
            return;
        }
     if(GetLocalInt(OBJECT_SELF,"bPDLVL"))
        if(d6() < 3)
        {
            MMP_PulseDrainLevel(oTarget);
            return;
        }
     if(GetLocalInt(OBJECT_SELF,"bPNEG"))
        if(d6() < 3)
        {
            MMP_PulseNegative(oTarget);
            return;
        }

    //if(d6() < 3) DEMON_Blink();

}




void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1003:
        if(GetCurrentAction() == ACTION_CASTSPELL) break;
        if(d6() < 3) MMPMRBD_SpecialAttack();
        break;
    }
}
