
export interface ClubIncomingMatches {
    matchDate: string,
    matchTime: string,
    leagueName: string,
    clubName: string,
    against: string,
    round: string,
    stadium: string,
    ha: string,
    squadId: number,
    
}

export class ClubIncomingMatches {
    constructor(
        matchDate: string,
        matchTime: string,
        leagueName: string,
        clubName: string,
        against: string,
        round: string,
        stadium: string,
        ha: string,
        squadId: number,
        
    ) {
       this.matchDate = matchDate;
       this.matchTime = matchTime;
       this.leagueName = leagueName;
       this.clubName = clubName;
       this.against = against;
       this.round = round;
       this.stadium = stadium;
       this.ha = ha;
       this.squadId = squadId; 
      
    }
}