void main()
{
object oChest = GetNearestObjectByTag("Locked");
 SetLockLockDC(oChest, 10);
 SetCustomToken(101, "10");
}
