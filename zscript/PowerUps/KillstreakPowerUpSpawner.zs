class KillStreakPowerUp : Inventory replaces MegaSphere
{
	Default
	{
		Inventory.PickupMessage "You got a Random Power Up!";
		Inventory.PickupSound "misc/p_pkup";
		+INVENTORY.ALWAYSPICKUP;
		+INVENTORY.AUTOACTIVATE;
		Inventory.MaxAmount 100;
	}

	static bool PoolItem(PlayerPawn p, String n)
	{
		if (!p || !p.player) return true;
		let c = CVar.GetCVar(n, p.player);
		return c == null || c.GetBool();
	}

	static void PushIf(Array<String> a, String itemCvar, String className, PlayerPawn p)
	{
		Class<Inventory> cls = className;
		if (PoolItem(p, itemCvar) && cls) a.Push(className);
	}

	static void RollKillstreakReward(PlayerPawn plr, out String outClass, out String outMsg)
	{
		Array<String> pool;
		PushIf(pool, "ksRewardHasteSphere", "KS_KSHasteSphere", plr);
		PushIf(pool, "ksRewardDoubleSphere", "KS_KSDoubleSphere", plr);
		PushIf(pool, "ksRewardInvulnSphere", "KS_KSInvulnerabilitySphere", plr);
		PushIf(pool, "ksRewardAmmoSphere", "AmmoSphere", plr);
		PushIf(pool, "ksCoffee", "CoffeeTime", plr);
		PushIf(pool, "ksTimesphere", "TFST", plr);
		PushIf(pool, "ksFamiliar", "FamiliarSummon", plr);
		PushIf(pool, "ksDroneFamiliar", "DroneSummon", plr);
		PushIf(pool, "ksGuardsphere", "GuardsphereST", plr);
		PushIf(pool, "ksCrucifix", "Crucifix", plr);
		PushIf(pool, "ksRegensphere", "RegenSphere", plr);
		PushIf(pool, "ksDeflectionsphere", "DeflectionSphere", plr);
		PushIf(pool, "ksLifeShield", "LifeshieldSphere", plr);
		PushIf(pool, "ksElectricsphere", "ElectricAuraSphere", plr);
		PushIf(pool, "ksLegendsphere", "LegendSphere", plr);
		PushIf(pool, "ksRewardBootsNorth", "BootsOfTheNorth", plr);
		PushIf(pool, "ksRewardBracersForce", "BracersOfForce", plr);
		PushIf(pool, "ksRewardBookDead", "BookOfTheDead", plr);
		PushIf(pool, "ksRewardFireAura", "FireAuraSphere", plr);
		PushIf(pool, "ksRewardFlightSphere", "FlightSphere", plr);
		PushIf(pool, "ksRewardFrostAura", "FrostAuraSphere", plr);
		PushIf(pool, "ksRewardWraithHand", "HandOfTheWraith", plr);
		PushIf(pool, "ksRewardLichSkull", "ArtiLichSkull", plr);
		PushIf(pool, "ksRewardPentacle", "PentacleOfProjection", plr);
		PushIf(pool, "ksRewardReflector", "ReflectorSphere", plr);

		if (pool.Size() < 1)
		{
			outClass = "";
			outMsg = "";
			return;
		}
		String pick = pool[random(0, pool.Size() - 1)];
		outClass = pick;
		outMsg = RewardMessageFor(pick);
	}

	static String RewardMessageFor(String pick)
	{
		if (pick == "KS_KSHasteSphere") return "Kill streak: Haste!";
		if (pick == "KS_KSDoubleSphere") return "Kill streak: Doom sphere (double damage)!";
		if (pick == "KS_KSInvulnerabilitySphere") return "Kill streak: Invulnerability!";
		if (pick == "AmmoSphere") return "Kill streak: Infinite ammo!";
		if (pick == "CoffeeTime") return "Kill streak: Coffee time!";
		if (pick == "TFST") return "Kill streak: Time sphere!";
		if (pick == "FamiliarSummon") return "Kill streak: Familiar summon!";
		if (pick == "DroneSummon") return "Kill streak: Drone familiar!";
		if (pick == "GuardsphereST") return "Kill streak: Guard sphere!";
		if (pick == "Crucifix") return "Kill streak: Crucifix!";
		if (pick == "RegenSphere") return "Kill streak: Regen sphere!";
		if (pick == "DeflectionSphere") return "Kill streak: Deflection sphere!";
		if (pick == "LifeshieldSphere") return "Kill streak: Lifeshield!";
		if (pick == "ElectricAuraSphere") return "Kill streak: Electric aura!";
		if (pick == "LegendSphere") return "Kill streak: Legend sphere!";
		if (pick == "BootsOfTheNorth") return "Kill streak: Boots of the North!";
		if (pick == "BracersOfForce") return "Kill streak: Bracers of Force!";
		if (pick == "BookOfTheDead") return "Kill streak: Book of the Dead!";
		if (pick == "FireAuraSphere") return "Kill streak: Fire aura!";
		if (pick == "FlightSphere") return "Kill streak: Flight sphere!";
		if (pick == "FrostAuraSphere") return "Kill streak: Frost aura!";
		if (pick == "HandOfTheWraith") return "Kill streak: Hand of the Wraith!";
		if (pick == "ArtiLichSkull") return "Kill streak: Lich skull!";
		if (pick == "PentacleOfProjection") return "Kill streak: Pentacle of Projection!";
		if (pick == "ReflectorSphere") return "Kill streak: Reflector sphere!";
		return "Kill streak power-up!";
	}

	override bool Use(bool pickup)
	{
		if (!Owner || !(Owner is "PlayerPawn")) return true;
		let plr = PlayerPawn(Owner);

		String className, msg;
		bool hadPending;
		KSHUDMessageHandler.KS_TakePending(plr, className, msg, hadPending);
		if (!hadPending)
			RollKillstreakReward(plr, className, msg);

		if (className == "")
			return true;

		Class<Inventory> rewardClass = className;
		if (!rewardClass)
		{
			plr.GiveInventory("Stimpack", 1);
			plr.A_Print("Kill streak: stimpack (reward class missing).", 2.0);
			return true;
		}

		plr.GiveInventory(className, 1);
		if (!KSHUDMessageHandler.UseBigScreenMsgs(plr))
			plr.A_Print(msg, 2.0);
		return true;
	}

	States
	{
	Spawn:
		MEGA A 6 Bright;
		MEGA B 6 Bright;
		Loop;
	}
}
