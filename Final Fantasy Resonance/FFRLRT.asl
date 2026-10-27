state("FFRS-Win64-Shipping")
{
  float Loading: "FFRS-Win64-Shipping.exe", 0x9A61220, 0x7B8, 0x408;	// Screenfade. 1 while fully black, 0 when fully faded in.
  int money: "FFRS-Win64-Shipping.exe", 0x9F90450, 0x338, 0x200, 0x28;	// Amount of money. Used for Inn check.
  int zeroInn: "FFRS-Win64-Shipping.exe", 0x9E951BC;	// 0 on most loads. Relevant for Inn check.
}


startup
{
	//Asks the user to set his timer to game time on livesplit if it isn't already
  	if (timer.CurrentTimingMethod == TimingMethod.RealTime) // Taken and reworded from FF7R 	Autosplitter
 	{
    		var timingMessage = MessageBox.Show 
    		(
      		"This game uses Time without Loads (Game Time) as the main timing method.\n"+
      		"LiveSplit is currently set to show Real Time (RTA).\n"+
      		"Would you like to set the timing method to Game Time?",
      		"LiveSplit | Final Fantasy Resonance",
      		MessageBoxButtons.YesNo,MessageBoxIcon.Question
    		);

    		if (timingMessage == DialogResult.Yes)
    		{
      			timer.CurrentTimingMethod = TimingMethod.GameTime;
    		}
  	}
}

init
{
	timer.IsGameTimePaused = false;
	vars.inn = false;	// Used to check if an Inn has been used as the fadeout isn't a load here.
}

update
{

}

split 
{

}

exit
{
	timer.IsGameTimePaused = true;
}

start 
{

}

isLoading 
{
	if (old.money - current.money == 100) 
  	{
        	vars.inn = true;
    	}

    	if ((vars.inn == true && old.Loading > current.Loading) || current.zeroInn == 0)
    	{
        	vars.inn = false;
    	}

	return current.Loading == 1 && vars.inn == false;
}