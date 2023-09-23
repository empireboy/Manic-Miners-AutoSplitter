state("ManicMiners-Win64-Shipping")
{
    // missionComplete changes between 1 and 4. The value is 4 whenever the mission complete popup is showing
    int missionComplete : "ManicMiners-Win64-Shipping.exe", 0x02EEE790, 0x20, 0xF8, 0x2A0, 0x20, 0x320, 0x128, 0xA48;
}

split
{
    // Split whenever the mission complete screen pops up
    if (current.missionComplete == 4 && current.missionComplete != old.missionComplete)
        return true;
}