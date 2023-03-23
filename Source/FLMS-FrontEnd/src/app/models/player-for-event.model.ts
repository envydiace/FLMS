export interface PlayerForEvent {
    playerId: number,
    name: string,
    avatar: string
}

export class PlayerForEvent implements PlayerForEvent {
    constructor(
        playerId: number,
        name: string,
        avatar: string
    ){
        this.playerId = playerId;
        this.name = name;
        this.avatar = avatar;
    }
}