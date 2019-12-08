function AddDebugPanel()
{
	var panel = $.CreatePanel("Panel", $('#KillSelector'), '');
	panel.BLoadLayoutSnippet("numKills", true);
	
}

function RemoveButtons(buttonToRemove)
{
	buttonToRemove.DeleteAsync(0);
}

function KillsPressed25()
{
	CountKills(Vote25);
	RemoveButtons(KillSelector);
}

function KillsPressed50()
{
	CountKills(Vote50);
	RemoveButtons(KillSelector);
}

function KillsPressed75()
{
	CountKills(Vote75);
	RemoveButtons(KillSelector);
}

function KillsPressed100()
{
	CountKills(Vote100);
	RemoveButtons(KillSelector);
}

function CountKills(vote)
{
var Vote25 = 0;
var Vote50 = 0;
var Vote75 = 0;
var Vote100 = 0;

if(vote = Vote25)
{
	Vote25 = Vote25 + 1;
}else if(vote = Vote50){
	Vote50 = Vote50 + 1;
}else if(vote = Vote75){
	Vote75 = Vote75 + 1;
}else if(vote = Vote100){
	Vote100 = Vote100 + 1;
}
	VoteTotals(Vote25, Vote50, Vote75, Vote100);
}

function VoteTotals(Vote25, Vote50, Vote75, Vote100)
{
	var Total25Votes = Vote25;
	var Total50Votes = Vote50;
	var Total75Votes = Vote75;
	var Total100Votes = Vote100;
	return 
}

function SetKills(dat)
{
	var killsToWin = VoteTotals(dat.Vote25,dat.Vote50,dat.Vote75,dat.Vote100);
}

function debug()
{
	$.Mag("Debug");
	AddDebugPanel();
	
	$.Schedule(30, function()
	{
		RemoveButtons(KillSelector);
	})
	
	GameEvents.Subscribe("setKillsToWin", SetKills);
}

debug();