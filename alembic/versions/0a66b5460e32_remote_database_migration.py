"""Remote database migration

Revision ID: 0a66b5460e32
Revises: cad1ce0dc926
Create Date: 2025-01-13 15:36:50.563331

"""
from typing import Sequence, Union
from alembic import op
import sqlalchemy as sa
from app.model.personal_package_payment import PackagePaymentStatusTypeEnum
from app.model.tour_package import TourPackagePaymentStatusTypeEnum

# revision identifiers, used by Alembic.
revision: str = '0a66b5460e32'
down_revision: Union[str, None] = 'cad1ce0dc926'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    PackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.create(op.get_bind(), checkfirst=True)

    op.create_table('personal_package_payment',
                    sa.Column('id', sa.Uuid(), nullable=False),
                    sa.Column('created_at', sa.DateTime(),
                              server_default=sa.text('now()'), nullable=False),
                    sa.Column('updated_at', sa.DateTime(),
                              server_default=sa.text('now()'), nullable=False),
                    sa.Column('deleted_at', sa.DateTime(), nullable=True),
                    sa.Column('transaction_ref', sa.String(
                        length=255), nullable=False),
                    sa.Column('payment_ref', sa.String(
                        length=255), nullable=True),
                    sa.Column('user_id', sa.Uuid(), nullable=True),
                    sa.Column('payment_gateway', sa.Enum('FLUTTERWAVE', 'STRIPE', name='payment_status_type_enum',
                                                         metadata=sa.MetaData(), create_constraint=True), nullable=True),
                    sa.Column('amount', sa.Integer(), nullable=False),
                    sa.Column('currency', sa.String(
                        length=255), nullable=False),
                    sa.ForeignKeyConstraint(
                        ['user_id'], ['users.id'], ondelete='CASCADE'),
                    sa.PrimaryKeyConstraint('id'),
                    sa.UniqueConstraint('payment_ref'),
                    sa.UniqueConstraint('transaction_ref')
                    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('personal_package_payment')
    # ### end Alembic commands ###
    PackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)
    TourPackagePaymentStatusTypeEnum.drop(op.get_bind(), checkfirst=True)
