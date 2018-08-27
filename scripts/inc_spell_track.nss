
// 5.3 changed public cd key to player name
/*#*#*#*#*#*#*#**#* SPELL TRACKING SYSTEM *#*#*#*#*#*#*#*#*
Spell Tracking System by Archaegeo
December 2002
File: inc_spell_track
Purpose: Tracks each use of a spell, or a feat with an
         associated spell effect.  This must be included
         in each spell you wish to track.  These spells
         are the nw_s0_ and nw_s2 series of files.
         See nw_s0_resis for an example.  If you are using
         HCR, you may put the text below between // // at
         the very start of wm_include's WildMagicOverride()
         See manual for more about using this with HCR.
#*#*#*#*#*#*#**#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
*/
void spell_track()
{
// SPELL TRACKING BEGIN
    if(GetSpellCastItem()==OBJECT_INVALID)
    {
        object oW=GetLastSpellCaster();
        if(oW==OBJECT_INVALID) oW=OBJECT_SELF;
        string sNm=GetName(oW);
        string sPC=GetPCPlayerName(oW);
        int nSp=GetSpellId();
        object oMd=GetModule();
        int nTm=GetLocalInt(oMd, "SPTRK"+sNm+sPC+IntToString(nSp));
        SetLocalInt(oMd,"SPTRK"+sNm+sPC+IntToString(nSp), (nTm+1));
    }
// END SPELL TRACKING

}
