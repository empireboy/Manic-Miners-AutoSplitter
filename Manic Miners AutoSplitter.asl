state("ManicMiners-Win64-Shipping")
{
    // missionComplete changes between 1 and 4. The value is 4 whenever the mission complete popup is showing
    int missionComplete : "ManicMiners-Win64-Shipping.exe", 0x02DDF718, 0x1928, 0x580, 0x348, 0x2C0, 0x28, 0x110, 0x3F0, 8;

    // missionStart changes between random numbers when the black screen before mission start pops up
    int missionStart : "ManicMiners-Win64-Shipping.exe", 0x02EE7098, 0x70, 0xF0, 0x30, 0x50, 0x2C8, 0x50, 0x11C;

    // missionStartInstructions changes from 3 to 4 whenever you press the play button in the instructions menu
    int missionStartInstructions : "ManicMiners-Win64-Shipping.exe", 0x2AFC4A8;
}

startup
{
    // The fullgamerun setting will be added in the LiveSplit GUI. Toggling it will affect when the run starts
    // Setting this to false will mean that you are doing an individual level runs
    settings.Add("fullgamerun", true, "Full Game Run");
    settings.SetToolTip("fullgamerun", "Turn this on when doing a full game run. Turn this off when doing individual level runs. This will affect when the timer begins.");
}

start
{
    // Starts the timer whenever the black screen before mission start pops up.
    // The missionStart value seems to be very high, very small (below zero) or zero when the game starts or ends,
    // so without the additional checks it will start the timer when you start or close the game
    if (
        settings["fullgamerun"] &&
        current.missionStart <= 100 &&
        current.missionStart > 0 &&
        current.missionStart != old.missionStart
    )
        return true;

    // Starts the timer whenever you press play in the instructions menu
    // Changes from 3 to 4 whenever you press the play button
    if (
        !settings["fullgamerun"] &&
        current.missionStartInstructions == 4 &&
        old.missionStartInstructions == 3 &&
        current.missionStartInstructions != old.missionStartInstructions
    )
        return true;
}

split
{
    // Split whenever the mission complete screen pops up
    if (current.missionComplete == 4 && current.missionComplete != old.missionComplete)
        return true;
}