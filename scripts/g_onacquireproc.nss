#include "g_common"

void OnAcquiredProc() {
    object oObject = GetModuleItemAcquired();
    object oOwner = GetItemPossessor(oObject);
    string strItemTag = GetStringLowerCase(GetTag(oObject));

    // Handled Cursed Items
    if (String_IsSubString(strItemTag, "cu_cursed")) if (!Curse_GetState(oOwner, strItemTag)) Curse_SetState(oOwner, strItemTag, TRUE);
}
