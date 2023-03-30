import { ClubListComponent } from './club/club-list/club-list.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';
import { HomepageComponent } from './homepage/homepage.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { ChangePasswordComponent } from '../flms/profile/change-password/change-password.component';
import { ForgotPassComponent } from './forgot-pass/forgot-pass.component';
import { LeagueListComponent } from './league/league-list/league-list.component';
import { LeagueDetailComponent } from './league/league-detail/league-detail.component';
import { MatchDetailComponent } from './match/match-detail/match-detail.component';
import { PlayerInfoComponent } from './club/player-info/player-info.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: '/home',
    pathMatch: 'full'
  },
  {
    path: 'home',
    component: HomepageComponent
  },
  {
    path: 'login',
    component: LoginComponent
  },
  {
    path: 'register',
    component: RegisterComponent
  },
  {
    path: 'forgot-pass',
    component: ForgotPasswordComponent
  },
  {
    path: 'club-info',
    component: ClubDetailComponent
  },
  {
    path: 'league-info',
    component: LeagueDetailComponent
  },
  {
    path: 'change-password',
    component: ChangePasswordComponent
  },
  {
    path: 'forgot-pass',
    component: ForgotPassComponent
  },
  {  
    path : 'club-list',
    component: ClubListComponent
  },
  {  
    path : 'league-list',
    component: LeagueListComponent
  },
  {  
    path : 'match-info',
    component: MatchDetailComponent
  },
  {  
    path : 'player-info',
    component: PlayerInfoComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class GuestViewRoutingModule { }
