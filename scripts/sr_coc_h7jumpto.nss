void main()
{
    location lSwimWP = GetLocation(GetObjectByTag("Landing_WP1"));

    AssignCommand(GetPCSpeaker(), ActionJumpToLocation(lSwimWP));
}
