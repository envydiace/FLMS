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
    canActivate: [AuthGuard, RoleGuard],
    data: { expectedRole: 'LEAGUE_MANAGER' }
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
    canActivate: [AuthGuard]
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
