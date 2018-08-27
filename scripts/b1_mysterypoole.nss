void main()
{
    object oPool =  GetObjectByTag("b1_mysterypool");
    if(!GetLocalInt(oPool,"bPurified"))
    {
        SendMessageToPC(GetFirstPC(),"This pool is full of disgusting slime and the liquid has a nasty smell");
    }

}
