using Godot;
using System;

public partial class ParallaxBackground : Godot.ParallaxBackground
{
	[Export]
	float trees_Speed = -10f;

	ParallaxLayer treesLayer;
	TileMapLayer treesSprites;

	public override void _Ready()
	{        
		treesLayer = GetNode<ParallaxLayer>("trees");
		treesSprites = treesLayer.GetNode<TileMapLayer>("TileMapLayer");
	}

}
