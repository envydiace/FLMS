import { CoupleNode } from './league-tree.model';

export interface LeagueStatisticTypeKO {
    messageCode: string;
    message: string;
    leagueId: number;
    leagueType: string;
    height: number;
    listNode: CoupleNode[];
    topScore: LeagueStatisticPlayer[];
    topAssist: LeagueStatisticPlayer[];
}

export class LeagueStatisticTypeKO implements LeagueStatisticTypeKO {
    constructor(
        messageCode: string,
        message: string,
        leagueId: number,
        leagueType: string,
        height: number,
        listNode: CoupleNode[],
        topScore: LeagueStatisticPlayer[],
        topAssist: LeagueStatisticPlayer[]
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.leagueId = leagueId;
        this.leagueType = leagueType;
        this.height =height;
        this.listNode = listNode;
        this.topScore = topScore;
        this.topAssist = topAssist;
    }
}

export interface LeagueStatisticPlayer {
    playerId: number;
    playerName: string;
    avatar: string;
    record: number;
    clubName: string;
    clubLogo: string;
}

export class LeagueStatisticPlayer implements LeagueStatisticPlayer {
    constructor(
        playerId: number,
        playerName: string,
        avatar: string,
        record: number,
        clubName: string,
        clubLogo: string
    ) {
        this.playerId = playerId;
        this.playerName = playerName;
        this.avatar = avatar;
        this.record = record;
        this.clubName = clubName;
        this.clubLogo = clubLogo;
    }
}