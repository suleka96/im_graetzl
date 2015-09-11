require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET show' do
    context 'when logged out' do
      before { get :show, id: create(:user) }

      it 'redirects to login with flash' do
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      let(:graetzl) { create(:graetzl) }
      let(:user) { create(:user, graetzl: graetzl) }
      before { sign_in create(:user) }

      context 'with right graetzl' do
        before { get :show, graetzl_id: graetzl, id: user }
        
        it 'assigns @graetzl' do
          expect(assigns(:graetzl)).to eq graetzl
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it 'renders :show' do
          expect(response).to render_template(:show)
        end
      end
      context 'with wrong graetzl' do
        let(:wrong_graetzl) { create(:graetzl) }
        before { get :show, graetzl_id: wrong_graetzl, id: user }
        
        it 'assigns @graetzl' do
          expect(assigns(:graetzl)).to eq wrong_graetzl
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it '301 redirects to user in right graetzl' do
          expect(response).to have_http_status(301)
          expect(response).to redirect_to [graetzl, user]
        end
      end
      context 'without graetzl' do
        before { get :show, id: user }

        it 'assigns @graetzl with nil' do
          expect(assigns(:graetzl)).to eq nil
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it '301 redirects to user in right graetzl' do
          expect(response).to have_http_status(301)
          expect(response).to redirect_to [graetzl, user]
        end
      end
    end
  end

  describe 'GET edit' do
    context 'when logged out' do
      it 'redirects to login with flash' do
        get :edit, id: create(:user)
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      let(:user) { create(:user) }
      before { sign_in user }

      context 'when user is other user' do
        it 'redirect_to to current_user with alert' do
          get :edit, id: create(:user)
          expect(response).to redirect_to([user.graetzl, user])
          expect(flash[:alert]).to be_present
        end
      end
      context 'when user is current_user' do
        before { get :edit, id: user }

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it 'renders :edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
  end
  describe 'PUT update' do
    context 'when logged out' do
      it 'redirects to login with flash' do
        put :update
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      context 'when user is other user' do
        it 'redirect_to to current_user with alert' do
          put :update, id: create(:user)
          expect(response).to redirect_to([user.graetzl, user])
          expect(flash[:alert]).to be_present
        end
      end
      context 'when user is current_user' do
      end
    end
  end
end