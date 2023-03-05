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
    leagueType: string;
    logo: string;
    totalPrize: number;
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
        leagueType: string,
        logo: string,
        totalPrize: number
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
        this.leagueType = leagueType;
        this.logo = logo;
        this.totalPrize = totalPrize;
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
