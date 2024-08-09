#include <a_samp>
#include <dini>

#define FILTERSCRIPT
#define COLOR_SHAKA 0xFFFFFFAA
#define COLOR_VIRGEM 0xFFFFFF00

new newScore[MAX_PLAYERS];
new killTimestamps[MAX_PLAYERS][11];
new killIndex[MAX_PLAYERS];

// Salva informações do jogador em um arquivo
stock SavePlayerInfo(playerid, reason[])
{
    new file[256], pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(file, sizeof(file), "players/%s_%d.ini", pname, playerid);

    new Float:health, Float:armour, Float:pos[3], Float:vel[3];
    new score = GetPlayerScore(playerid);
    new ping = GetPlayerPing(playerid);
    new skin = GetPlayerSkin(playerid);
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerVelocity(playerid, vel[0], vel[1], vel[2]);

    dini_Set(file, "Reason", reason);
    dini_IntSet(file, "ID", playerid);
    dini_Set(file, "Name", pname);
    dini_IntSet(file, "Skin", skin);
    dini_IntSet(file, "Score", score);
    dini_IntSet(file, "Ping", ping);
    dini_FloatSet(file, "Health", health);
    dini_FloatSet(file, "Armour", armour);
    dini_FloatSet(file, "PosX", pos[0]);
    dini_FloatSet(file, "PosY", pos[1]);
    dini_FloatSet(file, "PosZ", pos[2]);
    dini_FloatSet(file, "VelX", vel[0]);
    dini_FloatSet(file, "VelY", vel[1]);
    dini_FloatSet(file, "VelZ", vel[2]);
}

public OnFilterScriptInit()
{
    print("Inicializando ShakaByte-BOT!");
    print("ShakaByte-BOT Iniciado com sucesso!");
    return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, COLOR_SHAKA, "Iniciando modulos do ShakaByte-BOT");
    SendClientMessage(playerid, COLOR_VIRGEM, "Modulo V2.1 iniciado com sucesso!");
    SendClientMessage(playerid, COLOR_VIRGEM, "[ShakaByte-INFO] Todos os modulos V1 Iniciados com sucesso!");

    new ip[16];
    GetPlayerIp(playerid, ip, sizeof(ip));
    if (strfind(ip, "10.", true) == 0 || strfind(ip, "172.", true) == 0 || strfind(ip, "192.", true) == 0)
    {
        SendClientMessage(playerid, -1, "[ShakaByte-BOT] Desconectado por uso de VPN/Proxy.");
        Kick(playerid);
    }

    return 1;
}

public OnPlayerSpawn(playerid)
{
    newScore[playerid] = GetPlayerScore(playerid);
    return 1;
}

public OnPlayerUpdate(playerid)
{
    if (!IsPlayerAdmin(playerid))
    {
        new Float:health, Float:vel[3], Float:pos[3];
        GetPlayerHealth(playerid, health);
        GetPlayerVelocity(playerid, vel[0], vel[1], vel[2]);
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

        if (health > 400.0) KickPlayer(playerid, "ter vida acima do permitido");
        if (floatabs(vel[0]) > 400.0 || floatabs(vel[1]) > 400.0 || floatabs(vel[2]) > 400.0) KickPlayer(playerid, "excesso de velocidade");
        if (pos[2] > 2000.0 || pos[2] < -50.0) KickPlayer(playerid, "estar em uma altura inválida");

        new score = GetPlayerScore(playerid);
        if (score > newScore[playerid] + 10) KickPlayer(playerid, "alteração suspeita de score");
        newScore[playerid] = score;

        if (GetTickCount() - killTimestamps[playerid][killIndex[playerid] % 11] < 15000)
        {
            KickPlayer(playerid, "matar mais de 10 jogadores em 15 segundos");
        }
    }
    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if (!IsPlayerAdmin(playerid))
    {
        if (weaponid < 0 || weaponid > 46) KickPlayer(playerid, "usar uma arma inválida");
        if (amount > 100.0) KickPlayer(playerid, "causar dano excessivo");
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if (killerid != INVALID_PLAYER_ID && !IsPlayerAdmin(killerid))
    {
        killTimestamps[killerid][killIndex[killerid] % 11] = GetTickCount();
        killIndex[killerid]++;
    }
    return 1;
}

stock KickPlayer(playerid, reason[])
{
    SavePlayerInfo(playerid, reason);
    new msg[128];
    format(msg, sizeof(msg), "[ShakaByte-BOT] Você foi kickado por %s.", reason);
    SendClientMessage(playerid, -1, msg);
    Kick(playerid);
    return 1;
}