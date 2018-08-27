//:://////////////////////////////////////////////////
//:: Created By: Adam Miller
//:: Created On: 11/22/2002
//:: Modified By: JayAre
//:: Modified On: 08/07/2004
//:://////////////////////////////////////////////////

#include "nw_i0_tool"

void main()
{
  if (!(GetLocalInt(OBJECT_SELF, "A1_FINISHED") == 1))
  {
    SetLocalInt(OBJECT_SELF, "A1_FINISHED", 1);
    ExportAllCharacters();
    DoSinglePlayerAutoSave();
    DelayCommand(3.0, StartNewModule("A2 - Secret of The Slavers Stockade (HotU-CEP)"));
  }
}

