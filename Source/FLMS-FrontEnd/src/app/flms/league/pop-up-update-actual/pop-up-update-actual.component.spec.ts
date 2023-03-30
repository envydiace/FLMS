import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpUpdateActualComponent } from './pop-up-update-actual.component';

describe('PopUpUpdateActualComponent', () => {
  let component: PopUpUpdateActualComponent;
  let fixture: ComponentFixture<PopUpUpdateActualComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpUpdateActualComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpUpdateActualComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
