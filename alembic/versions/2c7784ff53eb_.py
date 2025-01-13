"""empty message

Revision ID: 2c7784ff53eb
Revises: 0a66b5460e32
Create Date: 2025-01-13 16:12:32.075994

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from app.model.personal_package_payment import PackagePaymentStatusTypeEnum
from app.model.tour_package import TourPackagePaymentStatusTypeEnum


# revision identifiers, used by Alembic.
revision: str = '2c7784ff53eb'
down_revision: Union[str, None] = '0a66b5460e32'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    PackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)

    op.create_table('accommodations',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('type', sa.String(length=2000), nullable=True),
    sa.Column('price', sa.Float(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('activities',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('description', sa.String(length=2000), nullable=True),
    sa.Column('price', sa.Float(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('google_verification',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('state', sa.String(length=255), nullable=False),
    sa.Column('auth_type', sa.String(length=255), nullable=False),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('regions',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('transportation',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('price', sa.Float(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('user_verification',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('session_id', sa.Uuid(), nullable=False),
    sa.Column('email', sa.String(length=255), nullable=False),
    sa.Column('token', sa.String(length=350), nullable=False),
    sa.Column('expires_at', sa.DateTime(timezone=True), server_default=sa.text("(NOW() AT TIME ZONE 'UTC') + INTERVAL '10 minutes'"), nullable=False),
    sa.PrimaryKeyConstraint('id', 'session_id'),
    sa.UniqueConstraint('email')
    )
    op.create_table('users',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
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
    op.create_table('personal_package_payment',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('transaction_ref', sa.String(length=255), nullable=False),
    sa.Column('payment_ref', sa.String(length=255), nullable=True),
    sa.Column('user_id', sa.Uuid(), nullable=True),
    sa.Column('payment_gateway', sa.Enum('FLUTTERWAVE', 'STRIPE', name='payment_status_type_enum', metadata=sa.MetaData(), create_constraint=True), nullable=True),
    sa.Column('amount', sa.Integer(), nullable=False),
    sa.Column('currency', sa.String(length=255), nullable=False),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('payment_ref'),
    sa.UniqueConstraint('transaction_ref')
    )
    op.create_table('tour_sites_region',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('name', sa.String(length=255), nullable=False),
    sa.Column('description', sa.String(length=2000), nullable=True),
    sa.Column('price', sa.Float(), nullable=False),
    sa.Column('region_id', sa.Uuid(), nullable=True),
    sa.ForeignKeyConstraint(['region_id'], ['regions.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('user_tour_packages',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('active', sa.Boolean(), nullable=True),
    sa.Column('user_id', sa.Uuid(), nullable=True),
    sa.Column('payment_status', sa.Enum('PENDING', 'SUCCESS', 'FAILED', name='tour_package_payment_status_type_enum', metadata=sa.MetaData(), create_constraint=True), nullable=True),
    sa.Column('tx_ref', sa.String(length=255), nullable=True),
    sa.Column('payment_gateway', sa.String(length=255), nullable=True),
    sa.Column('currency', sa.String(length=255), nullable=True),
    sa.Column('region_id', sa.Uuid(), nullable=True),
    sa.Column('accommodation_id', sa.Uuid(), nullable=True),
    sa.Column('no_of_people_attending', sa.Integer(), nullable=False),
    sa.Column('start_date', sa.Date(), server_default=sa.text('CURRENT_DATE'), nullable=True),
    sa.Column('end_date', sa.Date(), server_default=sa.text("CURRENT_DATE + INTERVAL '3 days'"), nullable=True),
    sa.ForeignKeyConstraint(['accommodation_id'], ['accommodations.id'], ),
    sa.ForeignKeyConstraint(['region_id'], ['regions.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('tour_package_accommodations',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('tour_package_id', sa.Uuid(), nullable=True),
    sa.Column('accommodation_id', sa.Uuid(), nullable=True),
    sa.ForeignKeyConstraint(['accommodation_id'], ['accommodations.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['tour_package_id'], ['user_tour_packages.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('tour_package_activities',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('tour_package_id', sa.Uuid(), nullable=True),
    sa.Column('activity_id', sa.Uuid(), nullable=True),
    sa.ForeignKeyConstraint(['activity_id'], ['activities.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['tour_package_id'], ['user_tour_packages.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('tour_package_tour_sites_region',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('tour_package_id', sa.Uuid(), nullable=True),
    sa.Column('tour_sites_region_id', sa.Uuid(), nullable=True),
    sa.ForeignKeyConstraint(['tour_package_id'], ['user_tour_packages.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['tour_sites_region_id'], ['tour_sites_region.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('tour_package_transportations',
    sa.Column('id', sa.Uuid(), nullable=False),
    sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
    sa.Column('deleted_at', sa.DateTime(), nullable=True),
    sa.Column('tour_package_id', sa.Uuid(), nullable=True),
    sa.Column('transportation_id', sa.Uuid(), nullable=True),
    sa.ForeignKeyConstraint(['tour_package_id'], ['user_tour_packages.id'], ondelete='CASCADE'),
    sa.ForeignKeyConstraint(['transportation_id'], ['transportation.id'], ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('tour_package_transportations')
    op.drop_table('tour_package_tour_sites_region')
    op.drop_table('tour_package_activities')
    op.drop_table('tour_package_accommodations')
    op.drop_table('user_tour_packages')
    op.drop_table('tour_sites_region')
    op.drop_table('personal_package_payment')
    op.drop_table('users')
    op.drop_table('user_verification')
    op.drop_table('transportation')
    op.drop_table('regions')
    op.drop_table('google_verification')
    op.drop_table('activities')
    op.drop_table('accommodations')
    # ### end Alembic commands ###
    PackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)

