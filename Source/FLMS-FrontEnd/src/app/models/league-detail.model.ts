
export interface LeagueDetail {
    leagueId: number;
    userId: number;
    managerName: string;
    leagueName: string;
    noParticipate: number;
    startDate: Date;
    endDate: Date;
    maxNoPlayer: number;
    noPlayerSquad: number;
    location: string;
    fanpage: string;
    createAt: Date;
    description: string;
    leagueType: string;
    noRound: number;
    logo: string;
    totalPrize: number;
    isFinished: boolean;
}

export class LeagueDetail implements LeagueDetail {
    constructor(
        leagueId: number,
        userId: number,
        managerName: string,
        leagueName: string,
        noParticipate: number,
        startDate: Date,
        endDate: Date,
        maxNoPlayer: number,
        noPlayerSquad: number,
        location: string,
        fanpage: string,
        createAt: Date,
        description: string,
        leagueType: string,
        noRound: number,
        logo: string,
        totalPrize: number,
        isFinished: boolean
    ) {
        this.leagueId = leagueId;
        this.userId = userId;
        this.managerName = managerName;
        this.leagueName = leagueName;
        this.noParticipate = noParticipate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.maxNoPlayer = maxNoPlayer;
        this.noPlayerSquad = noPlayerSquad;
        this.location = location;
        this.fanpage = fanpage;
        this.createAt = createAt;
        this.description = description;
        this.leagueType = leagueType;
        this.noRound = noRound;
        this.logo = logo;
        this.totalPrize = totalPrize;
        this.isFinished = isFinished;
    }
}

export interface LeagueListbyUser {
    leagueId: number,
    userId: number,
    leagueName: string,
}

export class LeagueListbyUser implements LeagueListbyUser {
    constructor(
        leagueId: number,
        userId: number,
        leagueName: string,
    ) {
        this.leagueId = leagueId;
        this.userId = userId;
        this.leagueName = leagueName;
    }
}

export class TopLeaguePrizes {
    topLeaguePrizes: LeagueDetail[];
}


export interface GetUpdateLeagueDetail{
    leagueId:number;
    leagueName: string;
    location: string;
    fanpage: string;
    logo: string;

}

export class GetUpdateLeagueDetail implements GetUpdateLeagueDetail{
    constructor(
        leagueId:number,
        leagueName: string,
        location: string,
        fanpage: string,
        logo: string,
    
    ){
        this.leagueId = leagueId;
        this.leagueName = leagueName;
        this.location = location;
        this.fanpage =fanpage;
        this.logo = logo
    }
}