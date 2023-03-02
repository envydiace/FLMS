import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';

const routes: Routes = [
  {
    path: 'create-club',
    component: CreateClubComponent
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
