state("ManicMiners-Win64-Shipping")
{
    // missionComplete changes between random values when you press Finish or (Finish) Fast. The value is 2 lower than the previous value whenever you press the button
    int missionComplete : "ManicMiners-Win64-Shipping.exe", 0x02CACC48, 0x88, 0x48, 0x0, 0x28, 0x58, 0x178, 0xC;

    // missionStart changes between random numbers when the black screen before mission start pops up
    int missionStart : "ManicMiners-Win64-Shipping.exe", 0x02EE7098, 0x70, 0xF0, 0x30, 0x50, 0x2C8, 0x50, 0x11C;
}

start
{
    // Starts the timer whenever the black screen before mission start pops up.
    // The missionStart value seems to be very high, very small (below zero) or zero when the game starts or ends,
    // so without the additional checks it will start the timer when you start or close the game
    if (
        current.missionStart <= 100 &&
        current.missionStart > 0 &&
        current.missionStart != old.missionStart
    )
        return true;
}

split
{
    bool missionCompleteCondition =
        current.missionComplete == old.missionComplete - 2 &&
        current.missionComplete != old.missionComplete;

    if (missionCompleteCondition)
        return true;
}