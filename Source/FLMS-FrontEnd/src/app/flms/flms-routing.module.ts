import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';
import { RequestListComponent } from './request-list/request-list.component';
import { AuthGuard } from './../auth/auth.guard';
import { RoleGuard } from './../auth/role.guard';

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
    path: 'request-list',
    component: RequestListComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'view-profile',
    component: ViewProfileComponent,
    canActivate: [AuthGuard]
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
