#include "inc_mmp"
#include "inc_psychic"

void main()
{
     if(d6() < 3)
     {
        int nPoints = GetLocalInt(OBJECT_SELF,"nPoints");
        if(nPoints > 0)
        {
            __TurnCombatRoundOn(TRUE);

            int n = PSYCHIC_SpecialAttack(nPoints);
            SetLocalInt(OBJECT_SELF,"nPoints",nPoints-n);
            __TurnCombatRoundOn(FALSE);

        }
    }
    else ExecuteScript("x2_ai_mflayer",OBJECT_SELF);
}
