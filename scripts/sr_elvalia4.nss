void main()
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
        EffectVisualEffect(VFX_BEAM_HOLY), GetLocation(GetPCSpeaker()));
    int iBarrierState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYcoc_q2_barrier");
    if (iBarrierState == 20) {
        SendMessageToPC(GetPCSpeaker(), "Something goes wrong with the magic as you feel a painful surge!");
        DelayCommand(5.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("TheKeep"))));
    } else {
        if (d6() == 1) {
            switch (Random(7)+1) {
               case 1:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("MapPin_toEast"))));
                 break;
               case 2:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("MapNote_Exit1"))));
                 break;
               case 3:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("WP_SewersEnter"))));
                 break;
               case 4:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("MapPin_ShallowGraves"))));
                 break;
               case 5:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("MapPin_ShyTower"))));
                 break;
               case 6:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("MapPin_toQuas"))));
                 break;
               case 7:
                 DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("RaiseDead_WP"))));
                 break;
            }
        } else {
            DelayCommand(1.0, AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("CavesofChaos"))));
        }
    }
}
