void main()
{
    location lWalk = GetLocation(GetObjectByTag("WP_Spiritwalk"));
    AssignCommand(GetPCSpeaker(), JumpToLocation(lWalk));

}
