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
import { ChangePasswordComponent } from './change-password/change-password.component';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { ReactiveFormsModule } from '@angular/forms';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { SignupComponent } from './signup/signup.component';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule } from '@angular/forms';
import { ForgotPassComponent } from './forgot-pass/forgot-pass.component';
import { MatCardModule } from '@angular/material/card';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatTabsModule } from '@angular/material/tabs';
import { ClubScheduleComponent } from './club/club-detail/club-schedule/club-schedule.component';
import { ClubPlayerComponent } from './club/club-detail/club-player/club-player.component';
import { LeagueHistoryComponent } from './club/club-detail/league-history/league-history.component';
import { MatchHistoryComponent } from './club/club-detail/match-history/match-history.component';
import { LeagueScheduleComponent } from './league/league-detail/league-schedule/league-schedule.component';
import { JoinedClubsComponent } from './league/league-detail/joined-clubs/joined-clubs.component';
import { LeagueStatisticComponent } from './league/league-detail/league-statistic/league-statistic.component';
import { LeagueFeeComponent } from './league/league-detail/league-fee/league-fee.component';
import { LeagueSettingsComponent } from './league/league-detail/league-settings/league-settings.component';
import {MatTableModule} from '@angular/material/table';
import { CdkTableModule} from '@angular/cdk/table';

@NgModule({
  declarations: [
    HomepageComponent,
    LoginComponent,
    RegisterComponent,
    ClubListComponent,
    ClubDetailComponent,
    LeagueListComponent,
    LeagueDetailComponent,
    ChangePasswordComponent,
    SignupComponent,
    ForgotPassComponent,
    LeagueDetailComponent,
    ForgotPasswordComponent,
    ClubScheduleComponent,
    ClubPlayerComponent,
    LeagueHistoryComponent,
    MatchHistoryComponent,
    LeagueScheduleComponent,
    JoinedClubsComponent,
    LeagueStatisticComponent,
    LeagueFeeComponent,
    LeagueSettingsComponent
  ],
  imports: [
    CommonModule,
    GuestViewRoutingModule,
    MatButtonModule,
    MatIconModule,
    MatListModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatTableModule,
    MatCardModule,
    CdkTableModule,
    MatPaginatorModule,
    MatTabsModule,
    MatTableModule,
    MatGridListModule,
    MatFormFieldModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatInputModule,
    MatCardModule,
    MatSelectModule,
    MatPaginatorModule,
    FormsModule
  ]
})
export class GuestViewModule { }
