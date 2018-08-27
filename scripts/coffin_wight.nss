void main()
{
    if(!GetLocalInt(OBJECT_SELF,"bOpened"))
    {
        SetLocalInt(OBJECT_SELF,"bOpened",1);
        EffectSummonCreature("NW_WIGHT",VFX_DUR_ANTI_LIGHT_10,0.5);
    }
}
