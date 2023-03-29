import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpAddPlanComponent } from './pop-up-add-plan.component';

describe('PopUpAddPlanComponent', () => {
  let component: PopUpAddPlanComponent;
  let fixture: ComponentFixture<PopUpAddPlanComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpAddPlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpAddPlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
