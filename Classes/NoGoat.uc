class NoGoat extends NoMutatorBase;

var array<GGGoat> mGoats;
var Material invisibleMat;

function bool IsAllowedOnCurrentMap()
{
	local GGProgression progression;
	local int nrOfCollectiblesFoundOnMap;
	local string mapName;

	progression = class'GGEngine'.static.GetGGEngine().GetProgression();
	mapName = Locs( WorldInfo.GetMapName() );
	nrOfCollectiblesFoundOnMap = progression.GetNrOfCollectablesFoundOnMap( mapName );
	return (nrOfCollectiblesFoundOnMap >= GGGameInfo( WorldInfo.Game ).mIDsOfCollectiblesOnLevel.Length);
}

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	if(IsAllowedOnCurrentMap())
	{
		goat = GGGoat( other );
		if( goat != none )
		{
			if( IsValidForPlayer( goat ) )
			{
				mGoats.AddItem(goat);
			}
		}
	}
	else
	{
		DisplayUnavailableMessage();
	}

	super.ModifyPlayer( other );
}

function DisplayUnavailableMessage()
{
	ClearTimer(NameOf(DisplayUnavailableMessage));
	WorldInfo.Game.Broadcast(self, "No Goat in only available on this map after collecting all the trophies.");
	SetTimer(3.f, false, NameOf(DisplayUnavailableMessage));
}

event Tick( float deltaTime )
{
	local GGGoat goat;

	super.Tick( deltaTime );

	foreach mGoats(goat)
	{
		if(goat.Mesh.Materials[0] != invisibleMat)
		{
			SetInvisibleTexture(goat.Mesh);
		}
	}
}

function SetInvisibleTexture(MeshComponent targetComp)
{
	local int index;

	for(index=0 ; index <targetComp.GetNumElements() ; index++)
	{
		targetComp.SetMaterial(index, invisibleMat);
	}
}

DefaultProperties
{
	invisibleMat=Material'NoGoat.NoTexture'
}