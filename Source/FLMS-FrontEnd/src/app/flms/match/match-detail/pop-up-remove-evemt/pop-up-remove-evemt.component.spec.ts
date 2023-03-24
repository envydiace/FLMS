import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpRemoveEvemtComponent } from './pop-up-remove-event.component';

describe('PopUpRemoveEvemtComponent', () => {
  let component: PopUpRemoveEvemtComponent;
  let fixture: ComponentFixture<PopUpRemoveEvemtComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpRemoveEvemtComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpRemoveEvemtComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
