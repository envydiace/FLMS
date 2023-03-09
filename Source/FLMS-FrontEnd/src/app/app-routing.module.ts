import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FlmsComponent } from './flms/flms.component';
import { NotFoundComponent } from './guest-view/not-found/not-found.component';


const routes: Routes = [
  {
    //lazy-load
    path: '',
    loadChildren: () => import('./guest-view/guest-view.module').then(m => m.GuestViewModule)
  },
  {
    //lazy-load
    path: 'manager',
    component: FlmsComponent,
    loadChildren: () => import('./flms/flms.module').then(m => m.FlmsModule)
  },
  {
    path: '**',
    pathMatch: 'full',
    component: NotFoundComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
