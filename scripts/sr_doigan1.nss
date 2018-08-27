void main()
{
    object oJump = GetObjectByTag("MapNote_Gates");
    if (GetIsObjectValid(oJump) == TRUE)
    {
        AssignCommand(GetPCSpeaker(), JumpToObject(oJump));
    }
}
