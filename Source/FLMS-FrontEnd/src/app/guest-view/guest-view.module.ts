import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { GuestViewRoutingModule } from './guest-view-routing.module';
import { HomepageComponent } from './homepage/homepage.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { ClubListComponent } from './club/club-list/club-list.component';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { LeagueListComponent } from './league/league-list/league-list.component';
import { LeagueDetailComponent } from './league/league-detail/league-detail.component';
import { ChangePasswordComponent } from '../flms/profile/change-password/change-password.component';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { ReactiveFormsModule } from '@angular/forms';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { FormsModule } from '@angular/forms';
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
import { MatTableModule } from '@angular/material/table';
import { CdkTableModule } from '@angular/cdk/table';
import { MatChipsModule } from '@angular/material/chips';
import { MatDialogModule } from '@angular/material/dialog';
import { PopUpAddPlayerComponent } from './club/club-detail/pop-up-add-player/pop-up-add-player.component';
import { PopUpSendRegistrationComponent } from './league/league-detail/pop-up-send-registration/pop-up-send-registration.component';
import { PopUpSendInvitationComponent } from './club/club-detail/pop-up-send-invitation/pop-up-send-invitation.component';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatchDetailComponent } from './match/match-detail/match-detail.component';
import { MatchStatisticComponent } from './match/match-detail/match-statistic/match-statistic.component';
import { NotFoundComponent } from './not-found/not-found.component';
import { MatchEventComponent } from './match/match-detail/match-event/match-event.component';
import { PlayerInfoComponent } from './club/player-info/player-info.component';
import { ViewSquadComponent } from './match/match-detail/view-squad/view-squad.component';
import { ForgotPassChangeComponent } from './forgot-pass/forgot-pass-change/forgot-pass-change.component';
import { ForgotPassComponent } from './forgot-pass/forgot-pass/forgot-pass.component';
import { FooterComponent } from '../layouts/footer/footer.component';
import { TournamentTreeGvComponent } from './league/league-detail/league-statistic/tournament-tree-gv/tournament-tree-gv.component';
import { NgTournamentTreeModule } from 'ng-tournament-tree';

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
    LeagueDetailComponent,
    ClubScheduleComponent,
    ClubPlayerComponent,
    LeagueHistoryComponent,
    MatchHistoryComponent,
    LeagueScheduleComponent,
    JoinedClubsComponent,
    LeagueStatisticComponent,
    LeagueFeeComponent,
    LeagueSettingsComponent,
    PopUpAddPlayerComponent,
    PopUpSendRegistrationComponent,
    PopUpSendInvitationComponent,
    MatchDetailComponent,
    MatchStatisticComponent,
    NotFoundComponent,
    MatchEventComponent,
    PlayerInfoComponent,
    ViewSquadComponent,
    ForgotPassChangeComponent,
    ForgotPassComponent,
    FooterComponent,
    TournamentTreeGvComponent
  ],
  imports: [
    CommonModule,
    GuestViewRoutingModule,
    MatButtonModule,
    MatIconModule,
    MatToolbarModule,
    MatListModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatTableModule,
    MatSnackBarModule,
    MatChipsModule,
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
    FormsModule,
    MatDialogModule,
    NgTournamentTreeModule
  ],
  providers: [
    DatePipe
  ]
})
export class GuestViewModule { }
