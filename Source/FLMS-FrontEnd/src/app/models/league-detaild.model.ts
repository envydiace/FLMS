
export interface LeagueDetail{
    leagueId: number;
    leagueName: string;
    noParticipate: number;
    startDate: Date;
    endDate: Date;
    maxNoPlayer: number;
    noPlayerSquad:number;
    location: string;
    fangpage:string;
    createAt: Date;
    description:string;
    leagueType:string;
    noRound: number;
  
}

export class LeagueDetail implements LeagueDetail{
    constructor(
        leagueId: number,
        leagueName: string,
        noParticipate: number,
        startDate: Date,
        endDate: Date,
        maxNoPlayer: number,
        noPlayerSquad:number,
        location: string,
        fangpage:string,
        createAt: Date,
        description:string,
        leagueType:string,
        noRound: number
    ){
        this.leagueId = leagueId;
        this.leagueName = leagueName;
        this.noParticipate = noParticipate
        this.startDate = startDate;
        this.endDate = endDate;
        this.maxNoPlayer = maxNoPlayer;
        this.noPlayerSquad = noPlayerSquad;
        this.location=location;
        this.fangpage=fangpage;
        this.createAt = createAt;
        this.description=description;
        this.leagueType=leagueType;
        this.noRound = noRound;
    }
}