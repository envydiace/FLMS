import { leaguePrize } from './league-prize.model';

export interface createLeagueInfo {
    leagueName: string,
    noParticipate: number,
    startDate: Date,
    endDate: Date,
    maxNoPlayer: number,
    noPlayerSquad: number,
    location: string,
    fanpage: string,
    leagueType: string,
    noRound: number,
    description: string,
    logo: string,
    sponsored: number,
    prizes: leaguePrize[],
    fees: leaguePrize[]
}

export class createLeagueInfo implements createLeagueInfo {
    constructor(
        leagueName: string,
        noParticipate: number,
        startDate: Date,
        endDate: Date,
        maxNoPlayer: number,
        noPlayerSquad: number,
        location: string,
        fanpage: string,
        leagueType: string,
        noRound: number,
        description: string,
        logo: string,
        sponsored: number,
        prizes: leaguePrize[],
        fees: leaguePrize[]
    ) {
        this.leagueName = leagueName;
        this.noParticipate = noParticipate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.maxNoPlayer = maxNoPlayer;
        this.noPlayerSquad = noPlayerSquad;
        this.location = location;
        this.fanpage = fanpage;
        this.description = description;
        this.leagueType = leagueType;
        this.noRound = noRound;
        this.logo = logo;
        this.sponsored = sponsored;
        this.prizes = prizes;
        this.fees = fees;
    }
}