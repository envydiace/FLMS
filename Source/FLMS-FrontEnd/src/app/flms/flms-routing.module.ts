import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';
import { RequestListComponent } from './request-list/request-list.component';

const routes: Routes = [
  {
    path: 'manager',
    redirectTo: '/manager/create-club',
    pathMatch: 'full'
  },
  {
    path: 'create-club',
    component: CreateClubComponent
  },
  {
    path: 'request-list',
    component: RequestListComponent
  },
  {
    path: 'view-profile',
    component: ViewProfileComponent
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
