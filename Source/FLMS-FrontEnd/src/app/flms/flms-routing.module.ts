import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';
import { RequestListComponent } from './request-list/request-list.component';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { AuthGuard } from './../auth/auth.guard';
import { RoleGuard } from './../auth/role.guard';
import { CreateLeagueComponent } from './league/create-league/create-league.component';
import { ClubListComponent } from './club/club-list/club-list.component';
import { LeagueListComponent } from './league/league-list/league-list.component';
import { LeagueDetailComponent } from './league/league-detail/league-detail.component';
import { MatchDetailComponent } from './match/match-detail/match-detail.component';
import { JoinedLeagueComponent } from './club/joined-league/joined-league.component';
import { EditLineUpComponent } from './match/edit-line-up/edit-line-up.component';
import { ClubIncomingMatchComponent } from './match/club-incoming-match/club-incoming-match.component';
import { PlayerInfoComponent } from './club/player-info/player-info.component';

const routes: Routes = [
  {
    path: 'manager',
    redirectTo: '/manager/view-profile',
    pathMatch: 'full'
  },
  {
    path: 'create-club',
    component: CreateClubComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
  {
    path: 'create-league',
    component: CreateLeagueComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'LEAGUE_MANAGER' }
  },
  {
    path: 'my-league',
    component: LeagueListComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'LEAGUE_MANAGER' }
  },
  {
    path: 'my-league-info',
    component: LeagueDetailComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'request-list',
    component: RequestListComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'view-profile',
    component: ViewProfileComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'club-detail',
    component: ClubDetailComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'my-clubs',
    component: ClubListComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
  {
    path: 'match-detail',
    component: MatchDetailComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'joined-league',
    component: JoinedLeagueComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
  {
    path: 'edit-line-up',
    component: EditLineUpComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
  {
    path: 'incoming-matches',
    component: ClubIncomingMatchComponent,
    canActivate: [AuthGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
  {  
    path : 'player-detail',
    component: PlayerInfoComponent,
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'CLUB_MANAGER' }
  },
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
