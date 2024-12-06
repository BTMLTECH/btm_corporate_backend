"""Add user model

Revision ID: 697a4bfceeac
Revises: 
Create Date: 2024-11-20 10:23:43.437249

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '697a4bfceeac'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('users',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(timezone=True), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('email', sa.String(length=255), nullable=False),
    sa.Column('password', sa.String(length=255), nullable=True),
    sa.Column('phone', sa.String(length=24), nullable=True),
    sa.Column('provider', sa.String(length=24), nullable=True),
    sa.Column('email_verified', sa.Boolean(), nullable=True),
    sa.Column('address', sa.String(length=255), nullable=True),
    sa.Column('is_admin', sa.Boolean(), nullable=True),
    sa.Column('is_active', sa.Boolean(), nullable=True),
    sa.Column('last_login_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('email')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('users')
    # ### end Alembic commands ###
