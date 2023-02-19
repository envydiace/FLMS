import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GuestViewRoutingModule } from './guest-view-routing.module';
import { HomepageComponent } from './homepage/homepage.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { ClubListComponent } from './club/club-list/club-list.component';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { LeagueListComponent } from './league/league-list/league-list.component';
import { LeagueDetailComponent } from './league/league-detail/league-detail.component';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { ReactiveFormsModule } from '@angular/forms';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';



@NgModule({
  declarations: [
    HomepageComponent,
    LoginComponent,
    RegisterComponent,
    ClubListComponent,
    ClubDetailComponent,
    LeagueListComponent,
    LeagueDetailComponent,
    ForgotPasswordComponent
  ],
  imports: [
    CommonModule,
    GuestViewRoutingModule,
    MatButtonModule,
    MatIconModule,
    MatListModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatCardModule
  ]
})
export class GuestViewModule { }
