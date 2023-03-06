export interface token {
    accessToken: string,
    refreshToken: string,
    role: string
  }

export class token implements token{
    constructor(
        accessToken: string,
        refreshToken: string,
        role: string
    ){
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.role = role;
    }
}  