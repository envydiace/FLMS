export interface MailData{
    email: string,
    leagueManagerName: string,
    clubManagerName: string,
    clubName: string,
    leagueName: string,
    mailMessageCode: string,
    receiverRole: string
}

export class MailData implements MailData{
    constructor(
        email: string,
        leagueManagerName: string,
        clubManagerName: string,
        clubName: string,
        leagueName: string,
        mailMessageCode: string,
        receiverRole: string
    ){
        this.email = email,
        this.leagueManagerName = leagueManagerName,
        this.clubManagerName = clubManagerName,
        this.clubName = clubName,
        this.leagueName = leagueName,
        this.mailMessageCode = mailMessageCode,
        this.receiverRole = receiverRole
    }
}