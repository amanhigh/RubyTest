class RelationshipsController < ApplicationController
  def create
    current_user.relationships.create!(followed_id: params[:relationship][:followed_id])
  end

  def destroy
    Relationship.find(params[:id]).destroy
  end
end
