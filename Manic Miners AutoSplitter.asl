state("ManicMiners-Win64-Shipping")
{
    // missionComplete changes between 1 and 4. The value is 4 whenever the mission complete popup is showing
    int missionComplete : "ManicMiners-Win64-Shipping.exe", 0x02EEE860, 0x100, 0xF8, 0x160, 0x20, 0x2C8, 0x40, 0xE8;
}

split
{
    // Split whenever the mission complete screen pops up
    if (current.missionComplete == 4 && current.missionComplete != old.missionComplete)
        return true;
}