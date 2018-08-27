// * Henchman levels up
#include "nw_i0_henchman"
#include "nw_i0_generic"

void main()
{
  SpeakString("Levelling up.");
  object oNew = DoLevelUp(GetPCSpeaker());
                if (GetIsObjectValid(oNew) == TRUE)
                {
                    DelayCommand(1.0,AssignCommand(oNew, EquipAppropriateWeapons(GetPCSpeaker())));
                }

}
